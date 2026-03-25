class OrderMailer < ApplicationMailer
  default from: "Easy VTA <noreply@easyvta.com>"

  def confirmation(order)
    @order = order
    mail(
      to: "#{@order.customer_name} <#{@order.customer_email}>",
      subject: "Order #{@order.reference} received — Easy VTA"
    )
  end

  def admin_notification(order)
    @order = order
    mail(
      to: "admin@easyvta.com",
      subject: "New Order #{@order.reference} — Easy VTA"
    )
  end
end
