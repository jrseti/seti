class PatternMarksController < ApplicationController
  
  load_and_authorize_resource :except => :mark_pattern
  
  # GET /pattern_marks
  # GET /pattern_marks.xml
  def index
    @pattern_marks = PatternMark.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pattern_marks }
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

    @pattern_mark = PatternMark.new(params[:pattern_mark])
    
    # It's today's date
    @pattern_mark.date = Time.new.inspect

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
