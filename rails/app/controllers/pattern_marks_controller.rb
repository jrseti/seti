# Copyright 2011 Adobe Systems Incorporated. All Rights Reserved.
# NOTICE: Adobe permits you to use, modify, and distribute this file
#  in accordance with the terms of the Mozilla Public License (MPL) v1.1.
#

class PatternMarksController < ApplicationController

  
  # Enable Cross-Site Forgery protection at the individual controller level on everything except Session
  # The AIR app does its own cookie management, and isn't handling the hidden form elements correctly during Google OpenID authentication.

  protect_from_forgery
  
  load_and_authorize_resource :except => :mark_pattern
  
  include CsvHelper
  
  # GET /pattern_marks
  # GET /pattern_marks.xml
  # GET /pattern_marks.csv
  def index
    if params[:start_date] and params[:end_date] and params[:start_date].length==10 and params[:end_date].length==10
      @pattern_marks = PatternMark.where("created_at >= :start_date AND created_at <= :end_date",
        {:start_date => params[:start_date], :end_date => params[:end_date]})
    else
      @pattern_marks = PatternMark.scoped
    end
    respond_to do |format|
      format.html do
        @pattern_marks = @pattern_marks.page(params[:page])
        @parameters = params
        render :html => @pattern_marks
      end
      format.xml  { render :xml => @pattern_marks }
      format.csv do
        if params[:start_date] and params[:end_date] and params[:start_date].length==10 and params[:end_date].length==10
          filename = "pattern_marks_#{params[:start_date]}_#{params[:end_date]}.csv"
        else
          filename = "pattern_marks_all.csv"
        end
        render_csv @pattern_marks, filename
      end
    end
  end

  # GET /pattern_marks/1
  # GET /pattern_marks/1.xml
  def show
    @pattern_mark = PatternMark.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pattern_mark }
    end
  end

  # GET /pattern_marks/new
  # GET /pattern_marks/new.xml
  def new
    @pattern_mark = PatternMark.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pattern_mark }
    end
  end

  # GET /pattern_marks/1/edit
  def edit
    @pattern_mark = PatternMark.find(params[:id])
  end

  # POST /pattern_marks
  # POST /pattern_marks.xml
  def create

    puts request.env['HTTP_COOKIE'] ? "CPM/Cookie: " + request.env['HTTP_COOKIE'] : "No Cookie"
    
    @pattern_mark = PatternMark.new(params[:pattern_mark])
    
    # It's today's date
    @pattern_mark.date = Time.new.inspect
    
    
    # Now look to see whether we have any Patterns within .005 MHz
    
    

    respond_to do |format|
      if @pattern_mark.save
        format.html { redirect_to(@pattern_mark, :notice => 'Pattern mark was successfully created.') }
        format.xml  { render :xml => @pattern_mark, :status => :created, :location => @pattern_mark }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pattern_mark.errors, :status => :unprocessable_entity }
      end
    end
  end


  # Making a separate GET method for the app to actually mark a pattern.
  # Not fully RESTful, but Rails seems to somehow delete or change session information on a POST from AIR
  # http://stackoverflow.com/questions/5187582/rails-3-is-changing-session-id-on-post-from-air
  
  def mark_pattern
    authorize! :explore, PatternMark

    # Create the new pattern mark
    
    @pattern_mark = PatternMark.new(params[:pattern_mark])
    @pattern_mark.date = Time.new.inspect
    @pattern_mark.assign_to_pattern


    # And get back to the user (typically just the API)

    respond_to do |format|
      if @pattern_mark.save
        format.html { redirect_to(@pattern_mark, :notice => 'Pattern mark was successfully created.') }
        format.xml  { render :xml => @pattern_mark, :status => :created, :location => @pattern_mark }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pattern_mark.errors, :status => :unprocessable_entity }
      end
    end
  end



  # PUT /pattern_marks/1
  # PUT /pattern_marks/1.xml
  def update
    @pattern_mark = PatternMark.find(params[:id])

    respond_to do |format|
      if @pattern_mark.update_attributes(params[:pattern_mark])
        format.html { redirect_to(@pattern_mark, :notice => 'Pattern mark was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pattern_mark.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pattern_marks/1
  # DELETE /pattern_marks/1.xml
  def destroy
    @pattern_mark = PatternMark.find(params[:id])
    @pattern_mark.destroy

    respond_to do |format|
      format.html { redirect_to(pattern_marks_url) }
      format.xml  { head :ok }
    end
  end
end
