module Tickets
  class Update
    def initialize(params, id)
      @id = id
      @is_deleted = params[:is_deleted] if params[:is_deleted]
      @assigned_slot = params[:assigned_slot] if params[:is_deleted]
    end

    def call
      ticket = Ticket.where(is_deleted: false, id: @id)[0]
      unless ticket
        return { error_message: "No such active ticket found", status: 404 }
      end

      updates = {}
      updates[:is_deleted] = @is_deleted if @is_deleted.present?
      updates[:assigned_slot] = @assigned_slot if @assigned_slot.present?

      if ticket.update(updates)
        { success_message: "Ticket updated successfully", status: 200 }
      else
        { error_message: newTicket.errors.full_messages, status: 400 }
      end
    end
  end  
end