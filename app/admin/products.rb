ActiveAdmin.register Product do


  controller do
    def autocomplete
      respond_with Product.where( 'lower(description) like ?', "%#{params[ :q ].downcase}%" ), :location => nil
    end
  end
end
