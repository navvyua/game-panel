ActiveAdmin.register BugTicket do
  permit_params :bug_image, :description, :status, :title, :user_id

  actions :edit, :index, :show, :update

  filter :title
  filter :description
  filter :status
  filter :user_id
  filter :created_at, as: :date_range

  action_item do
    link_to 'To site', root_path
  end

  index do
    selectable_column
    column :user_id
    column :title
    column :description
    column :status
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :user_id
      row :bug_image do |bug|
        image_tag bug.bug_image.middle
      end
      row :title
      row :description
      row :status
      row :created_at
    end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :status
      f.input :user_id
      f.input :bug_image
    end
    f.actions
  end
end
