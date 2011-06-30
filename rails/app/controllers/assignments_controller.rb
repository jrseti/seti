# Copyright 2011 Adobe Systems Incorporated. All Rights Reserved.
# NOTICE: Adobe permits you to use, modify, and distribute this file
#  in accordance with the terms of the Mozilla Public License (MPL) v1.1.
#


class AssignmentsController < ApplicationController

  
  # Enable Cross-Site Forgery protection at the individual controller level on everything except Session
  # The AIR app does its own cookie management, and isn't handling the hidden form elements correctly during Google OpenID authentication.

  protect_from_forgery

  
  load_and_authorize_resource :except => :current_assignment_for_user
  
  include CsvHelper
  
  # GET /assignments
  # GET /assignments.xml
  # GET /assignments.csv
  def index
    if params[:start_date] && params[:end_date]
      @assignments = Assignment.where("created_at >= :start_date AND created_at <= :end_date",
        {:start_date => params[:start_date], :end_date => params[:end_date]})
    else
      @assignments = Assignment.scoped
    end
    respond_to do |format|
      format.html do
        @assignments = @assignments.page(params[:page])
        @parameters = params
        render :html => @assignments
      end
      format.xml  { render :xml => @assignments }
      format.csv do
        render_csv @assignments, "assignments_all.csv"
      end
    end
  end

  # GET /assignments/1
  # GET /assignments/1.xml
  def show
    @assignment = Assignment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @assignment }
    end
  end

  # GET /assignments/new
  # GET /assignments/new.xml
  def new
    @assignment = Assignment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @assignment }
    end
  end

  # GET /assignments/1/edit
  def edit
    @assignment = Assignment.find(params[:id])
  end

  # POST /assignments
  # POST /assignments.xml
  def create
    #@user = User.find(params[:assignment][:user])
    #@observation_range = ObservationRange.find(params[:assignment][:observation_range])
    @assignment = Assignment.new(params[:assignment])

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to(@assignment, :notice => 'Assignment was successfully created.') }
        format.xml  { render :xml => @assignment, :status => :created, :location => @assignment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @assignment.errors, :status => :unprocessable_entity }
      end
    end
  end



  # This is where the main app calls to get the next assignment for a user. It may create an assignment or return one that's already in progress.
  
  def current_assignment_for_user

    # This is just for debugging, until I figure out the session handling problem
    
    puts request.env['HTTP_COOKIE'] ? "CAFU/Cookie: " + request.env['HTTP_COOKIE'] : "No Cookie"
    authorize! :explore, Assignment
    
    # Once this is working right, we'll check first to see whether the user is already in the middle of an assignment.
    
    #@assignment = Assignment.find_by_user_id_and_status(current_user.id, :in_progress.to_str)
    
    #if @assignment.nil?
      observation_range = ObservationRange.find(:first, :offset => rand(ObservationRange.count))
      #@assignment = Assignment.new(:user => current_user, :observation_range => observation_range, :status => :in_progress)
      @assignment = Assignment.new(:user_id => current_user.id, :observation_range => observation_range, :status => :in_progress)
    #end
    

    # This code assumes new assignment, since it includes the save. Needs to change once we might be retrieving an assignment
    
    respond_to do |format|
      if @assignment.save
        format.html { render :action => 'show' }# show.html.erb
        format.xml  { render :xml => @assignment.to_xml(:include => {:observation_range => {:include => {:observation => {:include => :target}}}}), :content_type => Mime::XML }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @assignment.errors, :status => :unprocessable_entity }
      end
    end

  end 

  # PUT /assignments/1
  # PUT /assignments/1.xml
  def update
    @assignment = Assignment.find(params[:id])

    respond_to do |format|
      if @assignment.update_attributes(params[:assignment])
        format.html { redirect_to(@assignment, :notice => 'Assignment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @assignment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.xml
  def destroy
    @assignment = Assignment.find(params[:id])
    @assignment.destroy

    respond_to do |format|
      format.html { redirect_to(assignments_url) }
      format.xml  { head :ok }
    end
  end
end
