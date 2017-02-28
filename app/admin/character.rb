ActiveAdmin.register Character do
  actions :index, :show, :edit, :destroy

  filter :user_id
  filter :first_name
  filter :age
  filter :status
  filter :bank
  filter :cash
  filter :driving_license
  filter :created_at, label: 'Created at', as: :date_range

  scope :deleted do
    Character.only_deleted
  end

  action_item do
    link_to 'To site', root_path
  end

  permit_params :driving_license,
                :bank,
                :first_name,
                :last_name,
                :age,
                :biography,
                :status,
                :cash,
                :user_id,
                :deny_reason,
                :pos_x,
                :pos_y,
                :pos_z,
                :faсtion,
                :faction_id,
                :faction_role,
                :faction_rank

  index do
    selectable_column
    column :user_id
    column :first_name
    column :status
    column :bank
    column :cash
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :age
      row :bank
      row :cash
      row :status
      row :biography
      row :driving_liense
      row :deny_reason
      row :user_id
      row :pos_x
      row :pos_y
      row :pos_z
      row :faсtion
      row :faction_role
      row :faction_rank
    end
  end

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :age
      f.input :bank
      f.input :cash
      f.input :status
      f.input :biography
      f.input :driving_license
      f.input :deny_reason
      f.input :user_id
      f.input :pos_x
      f.input :pos_y
      f.input :pos_z
      f.input :faction
      f.input :faction_role
      f.input :faction_rank
    end
    f.actions
  end
end
