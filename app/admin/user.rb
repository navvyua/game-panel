ActiveAdmin.register User do
  actions :index, :show, :edit, :destroy

  filter :role, as: :select, collection: [['user', 0], ['helper', 1], ['admin', 2]]
  filter :name
  filter :email
  filter :created_at, label: 'Created at', as: :date_range

  scope :deleted do
    User.only_deleted
  end

  action_item do
    link_to 'To site', root_path
  end

  permit_params :online, :name, :email, :role, :first_name, :last_name, :age, :location, :about, :avatar

  index do
    selectable_column
    column 'Photo' do |user|
      image_tag user.avatar.thumb, class: 'index-image-size'
    end
    column :name
    column :email
    column :role
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :avatar do |user|
        image_tag user.avatar.thumb
      end
      row :online
      row :name
      row :email
      row :role
      row :first_name
      row :last_name
      row :age
      row :location
      row :about
      row :created_at
    end
  end

  form do |f|
    f.inputs do
      f.input :online
      f.input :name
      f.input :email
      f.input :role
      f.input :first_name
      f.input :last_name
      f.input :age
      f.input :location
      f.input :about
      f.input :avatar
    end
    f.actions
  end
end
