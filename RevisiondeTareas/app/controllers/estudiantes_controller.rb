class EstudiantesController < ApplicationController
  before_action :set_estudiante, only: [:show, :edit, :update, :destroy]

  # GET /estudiantes
  # GET /estudiantes.json
  def index
    @estudiantes = Estudiante.all
    @estudiantes3 = @estudiantes.where("name LIKE ?", "%#{params[:name]}%")
  end

  # GET /estudiantes/1
  # GET /estudiantes/1.json
  def show
  end

  # GET /estudiantes/new
  def new
    @estudiante = Estudiante.new
  end

  # GET /estudiantes/1/edit
  def edit
  end

  # POST /estudiantes
  # POST /estudiantes.json
  def create
    @estudiante = Estudiante.new(estudiante_params)
    if params[:asignaturas_ids]
      asignaturas = Asignatura.where(id: params[:asignaturas_ids])
      @estudiante.asignaturas << asignaturas
    end

    if @estudiante.save
      redirect_to estudiantes_path
    else
      redirect_to estudiantes_path, alert: "Error: #{@student.errors.full_messages.join(" ")}"
    end


    respond_to do |format|
      if @estudiante.save
        format.html { redirect_to @estudiante, notice: 'Estudiante was successfully created.' }
        format.json { render :show, status: :created, location: @estudiante }
      else
        format.html { render :new }
        format.json { render json: @estudiante.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /estudiantes/1
  # PATCH/PUT /estudiantes/1.json
  def update

    @estudiante = Estudiante.find(params[:id])
    @estudiante.update_attributes(estudiante_params)
    redirect_to mostrar_materias_path(@estudiante)

    respond_to do |format|
      if @estudiante.update(estudiante_params)
        format.html { redirect_to @estudiante, notice: 'Estudiante was successfully updated.' }
        format.json { render :show, status: :ok, location: @estudiante }
        
      else
        format.html { render :edit }
        format.json { render json: @estudiante.errors, status: :unprocessable_entity }
      end
    end
  end
    
    

  # DELETE /estudiantes/1
  # DELETE /estudiantes/1.json
  def destroy
    @estudiante.destroy
    respond_to do |format|
      format.html { redirect_to estudiantes_url, notice: 'Estudiante was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_estudiante
      @estudiante = Estudiante.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def estudiante_params
      params.require(:estudiante).permit(:name, :lastname, :identificacion, :email, :edad, :gender, { tareas_ids: [] }, { asignaturas_ids: [] } )
    end
end
