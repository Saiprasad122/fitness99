<?php

namespace App\Admin\Controllers;

use App\Models\User;
use App\Models\Status;
use App\Models\Goal;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class UserController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'User';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new User());

        $grid->column('id', __('Id'));
        $grid->column('user_name', __('User Name'));
        $grid->column('email', __('Email'));
        $grid->column('phone_number', __('Phone number'));
        $grid->column('height', __('Height'));
        $grid->column('weight', __('Weight'));
        $grid->column('gender', __('Gender'))->display(function($types){
            if ($types == 1) {
                return "<span class='label label-success'>Male</span>";
            } if ($types == 0) {
                return "<span class='label label-info'>Female</span>";
            }
        });
        $grid->column('date_of_birth', __('Date Of Birth'));
        $grid->column('status', __('Status'))->display(function($status){
            $status_name = Status::where('id',$status)->value('status_name');
            if ($status == 1) {
                return "<span class='label label-success'>$status_name</span>";
            } else {
                return "<span class='label label-danger'>$status_name</span>";
            }
        });
        $grid->disableExport();
        $grid->actions(function ($actions) {
            $actions->disableView();
        });

         $grid->filter(function ($filter) {
            //Get All status            
            $statuses = Status::pluck('status_name', 'Id');
            $goals = goal::pluck('goal_name', 'Id');
                       
            $filter->like('user_name', 'User Name');
            $filter->like('id_proof', 'Id Proof');
            $filter->like('email', 'Email');
            $filter->like('personal_goal', 'personal Goal');
            $filter->like('height', 'Height');
            $filter->like('weight', 'Weight');
            $filter->like('gender', 'Gender')->select([1 => 'Male', 0 => 'Female']);
            $filter->like('date_of_birth', 'Date Of Birth');
            $filter->equal('goal_name', 'Goal Id')->select($goals);
            $filter->equal('status', 'Status')->select($statuses);
        });

        return $grid;
    }

    /**
     * Make a show builder.
     *
     * @param mixed $id
     * @return Show
     */
    protected function detail($id)
    {
        $show = new Show(User::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('user_name', __('User name'));
        $show->field('id_proof', __('Id proof'));
        $show->field('email', __('Email'));
        $show->field('password', __('Password'));
        $show->field('profile_picture', __('Profile picture'));
        
        $show->field('status', __('Status'));
        $show->field('created_at', __('Created at'));
        $show->field('updated_at', __('Updated at'));

        return $show;
    }

    /**
     * Make a form builder.
     *
     * @return Form
     */
    protected function form()
    {
        $form = new Form(new User());
        
        $statuses = Status::pluck('status_name', 'Id');
        $goals = Goal::pluck('goal_name', 'Id');

        $form->text('user_name', __('User Name'))->rules(function ($form) {
            return 'required|max:250';
        });
        $form->image('id_proof', __('Id Proof'))->uniqueName();
        $form->email('email', __('Email'))->rules(function ($form) {
            return 'required';
        });
        $form->text('phone_number', __('Phone number'))->rules(function ($form) {
            if (!$id = $form->model()->id) {
                return 'numeric|digits_between:9,20|required|unique:users,phone_number';
            } else {
                return 'numeric|digits_between:9,20|required|unique:users,phone_number,'.$form->model()->id;
            }
        });
        $form->password('password', __('Password'))->rules(function ($form) {
            return 'required';
        });
        $form->image('profile_picture', __('Profile Picture'))->uniqueName();
       
        $form->text('height', __('Height'));
        $form->text('weight', __('Weight'));
        $form->select('gender', __('Gender'))->options([1 => 'Male', 0 => 'Female'])->rules(function ($form) {
            return 'required';
        });
        $form->date('date_of_birth', __('Date of birth'))->default(date('Y-m-d'));
        $form->select('status', __('Status'))->options($statuses)->default(1)->rules(function ($form) {
            return 'required';
        });
         $form->saving(function ($form) {
            
            if($form->password && $form->model()->password != $form->password)
            {
                $form->password = $this->getEncryptedPassword($form->password);
            }
   
        });
        $form->tools(function (Form\Tools $tools) {
           $tools->disableDelete(); 
           $tools->disableView();
       });
       $form->footer(function ($footer) {
           $footer->disableViewCheck();
           $footer->disableEditingCheck();
           $footer->disableCreatingCheck();
       });

        return $form;
    }
    public function getEncryptedPassword($input, $rounds = 12) {
        $salt = "";
        $saltchars = array_merge(range('A', 'Z'), range('a', 'z'), range(0, 9));
        for ($i = 0; $i < 22; $i++) {
            $salt .= $saltchars[array_rand($saltchars)];
        }
        return crypt($input, sprintf('$2y$%2d$', $rounds) . $salt);
    }
    
    
}
