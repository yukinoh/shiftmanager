class MembersController < ApplicationController
  
  def new
    
  end
  
  def create
    @members = Member.new(member_params)
    @members.save
  
    if @members.save
      redirect_to settings_index_path
    else
      #要エラー処理
      redirect_to settings_index_path
    end
    
  end
  
  def update
    m = Member.find(params[:id])
    m.update(member_params)
    redirect_to settings_index_path
  end
  
  def activate
    m = Member.find(params[:id])
    m.flg = true
    m.save
    
    redirect_to settings_index_path
  end

  
  def deactivate
    m = Member.find(params[:id])
    m.flg = false
    m.save
    
    redirect_to settings_index_path
  end

  
  private
  
  def member_params
    params.require(:member).permit(:id, :name, :email, :flg)
  end
  
end