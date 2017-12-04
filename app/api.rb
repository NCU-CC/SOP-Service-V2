module SopService
  class V2 < Grape::API
    prefix :sop
    version :v2
    format :json

    helpers OAuth::Helpers


    #=============================================================
    # GET /v2/user_info

    desc 'Get user information: { token: token_info, user: user_info }.'

    get '/user_info' do
      user_info
    end

    #=============================================================
    # GET /v2/marks

    desc 'Get marks of an user.'
    
    get 'marks' do
      Mark.by_user user_id
    end

    #=============================================================

    resource :sops do

      #=============================================================
      # GET /v2/sops

      desc 'Return SOPs with some conditions.'

      params do
        optional :author, type: String
        optional :marker, type: String
        optional :limit,  type: Integer
        optional :offset, type: Integer
        optional :with_mark, type: Integer
      end

      get do
        p = declared(params, include_missing: false)
        Sop.select_by_params p
      end

      #=============================================================
      # POST /v2/sops

      desc 'Create SOP.'

      params do
        requires :name, type: String
        requires :desc, type: String
        requires :author, type: String
        requires :unit, type: String
        requires :steps, type: Array[String], coerce_with: JSON
      end

      post do
        p = declared(params, include_missing: false)
        p[:author] = user_id
        Sop.create! p
      end

      #=============================================================
      # GET /v2/sops/:id

      desc 'Return detail of a single SOP.'

      params do
        requires :id, type: Integer
      end

      get ':id' do
        Sop.find_by_id params[:id]
      end
      
      #=============================================================
      # PUT /v2/sops/:id

      desc 'Update SOP.'

      params do
        requires :id, type: Integer
        optional :name, type: String
        optional :desc, type: String
        optional :author, type: String
        optional :unit, type: String
        optional :steps, type: Array[String], coerce_with: JSON
      end

      put ':id' do
        p = declared(params, include_missing: false)
        p[:author] = user_id
        Sop.update_by_params p
      end

      #=============================================================
      # DELETE /v2/sops/:id

      desc 'Delete SOP.'

      params do
        requires :id, type: Integer
      end

      delete ':id' do
        Sop.remove params[:id], user_id
      end

      #=============================================================
      # GET /v2/sops/:id/mark

      desc 'Add SOP to bookmarks.'
      
      params do
        requires :id, type: Integer
      end

      get ':id/mark' do
        Mark.exist? params[:id], user_id
      end

      #=============================================================
      # POST /v2/sops/:id/mark

      desc 'Add SOP to bookmarks.'

      params do
        requires :id, type: Integer
      end

      post ':id/mark' do
        Mark.add params[:id], user_id
      end

      #=============================================================
      # DELETE /v2/sops/:id/mark

      desc 'Delete SOP in bookmarks.'

      params do
        requires :id, type: Integer
      end

      delete ':id/mark' do
        Mark.del params[:id], user_id
      end

      #=============================================================
    end
  end
end
