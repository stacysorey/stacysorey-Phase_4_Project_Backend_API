class Api::V1::JournalsController < ApplicationController
  before_action :set_journal, only: [:show, :update, :destroy]

  # GET /journals
  def index
    @journals = Journal.all

    render json: @journals, only: [:title, :id], include: {
      entries: { 
        except: [:created_at, :updated_at]
       }
    }
  end

  # GET /journals/1
  def show
    render json: @journal, only: [:title, :id], include: {
      entries: {
        except: [:created_at, :updated_at]
      }
    }
  end

  # POST /journals
  def create
    @journal = Journal.new(journal_params)

    if @journal.save
      render json: {
        status: 201,
        journal: @journal
      },
        status: :created, location: api_v1_journal_path(@journal)
    else
      render json: {
        status: 422,
        errors: @journal.errors.full_messages.join(",")
      },
        status: :unprocessable_entity
    end
  end

  # PATCH/PUT /journals/1
  def update
    if @journal.update(journal_params)
      render json: {
        status: 204,
        journal: @journal
      }
    else
      render json: {
        status: 400, 
        errors: @journal.errors.full_messages.join(",")
      }, 
        status: :unprocessable_entity
    end
  end

  # DELETE /journals/1
  def destroy
    if @journal.destroy
      render json: {message: "Successfully deleted", journal: @journal}
    else
      render json: {message: "Failed to delete"}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_journal
      @journal = Journal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def journal_params
      params.require(:journal).permit(:title)
    end
end
