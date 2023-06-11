module Tickets
  class Update
    def initialize(params, id)
      @id = id
      @is_deleted = params[:is_deleted] if params[:is_deleted]
    end

    def call
      ticket = Ticket.where(is_deleted: false, id: @id)[0]
      unless ticket
        return { error_message: "No such active ticket found", status: 404 }
      end

      updates = {}
      updates[:is_deleted] = @is_deleted if @is_deleted.present?

      if ticket.update(updates)
        { success_message: "Ticket updated successfully", status: 200 }
      else
        { error_message: ticket.errors.full_messages.join(", "), status: 400 }
      end
    end
  end  
end