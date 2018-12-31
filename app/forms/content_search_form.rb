class ContentSearchForm < SearchForm
  attr_accessor :deleted

  like_attributes :title
  equal_attributes :category_id

  def custom_hook(scoped)
    scoped = scoped.alive_records

    # if account_type.present?
    #   scoped = scoped.where(account_type: AdminUser.account_types[account_type])
    # end
    #
    # if branch_ids.present?
    #   branch_ids.delete("")
    #   if branch_ids.present?
    #     scoped = scoped.eager_load(:branches).where(branches: { id: branch_ids })
    #   end
    # end
    #
    # if email.present?
    #   scoped = scoped.eager_load(:admin_user_emails).where('admin_user_emails.email LIKE ?', "%#{email}%")
    # end
    #
    # if maker_id.present?
    #   #scoped = scoped.joins(:maker).where('maker.maker_id = ?', "#{maker_id}").where('maker.maker_id = ?', "#{maker_id}")
    # end
    scoped.order(id: :desc)
  end
end
