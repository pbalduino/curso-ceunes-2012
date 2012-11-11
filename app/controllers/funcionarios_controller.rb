#encoding: UTF-8 

class FuncionariosController < ApplicationController

	def index
		@funcionarios = Funcionario.all
	end

	def show
		@funcionario = Funcionario.find params[:id]
	end

	def edit
		@funcionario = Funcionario.find params[:id]

		@departamentos = Departamento.all
	end

  def update
    @funcionario = Funcionario.find(params[:id])

    date = params[:funcionario][:admissao]

    @funcionario.admissao = text_to_date(date)

    if @funcionario.update_attributes(params[:funcionario])
      redirect_to @funcionario, notice: 'Funcionário was successfully updated.'
    else
    	render action: "edit"
    end # if
  end # def

  def new
  	@funcionario = Funcionario.new
  	@departamentos = Departamento.all
  end

  def destroy
    @funcionario = Funcionario.find(params[:id])
    @funcionario.destroy

    redirect_to funcionarios_url
  end

  def create
    @funcionario = Funcionario.new(params[:funcionario])
    @funcionario.admissao = text_to_date(params[:funcionario][:admissao])

    if @funcionario.save
      redirect_to @funcionario, notice: 'Funcionário was successfully created.'
    else
      render action: "new"
    end
  end

  private

  def text_to_date(text) 
  	parts = text.split("/")
  	Date.new parts[2].to_i, parts[1].to_i, parts[0].to_i
  end

end #class