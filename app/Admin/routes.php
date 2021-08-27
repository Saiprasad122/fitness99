<?php

use Illuminate\Routing\Router;

Admin::routes();

Route::group([
    'prefix'        => config('admin.route.prefix'),
    'namespace'     => config('admin.route.namespace'),
    'middleware'    => config('admin.route.middleware'),
    'as'            => config('admin.route.prefix') . '.',
], function (Router $router) {

     $router->get('/', 'HomeController@index')->name('home');

     $router->resource('users', UserController::class);
     $router->resource('groups', GroupController::class);
     $router->resource('group-members', GroupMemberController::class);
     $router->resource('preferences', PreferenceController::class);
     $router->resource('interests', InterestController::class);
     $router->resource('statuses', StatusController::class);
     $router->resource('event-statuses', EventStatusController::class);
     $router->resource('invite-statuses', InviteStatusController::class);
     $router->resource('group-activities', GroupActivityController::class);
     $router->resource('events', EventController::class);
     $router->resource('days', DayController::class);
     $router->resource('goals', GoalController::class);
     $router->resource('user-groups', UserGroupController::class);
     $router->resource('user-goals', UserGoalController::class);
     $router->resource('user-preferences', UserPreferenceController::class);
     $router->resource('user-interests', UserInterestController::class);
     $router->resource('user-activities', UserActivityController::class);
     $router->resource('activities', ActivityController::class);
     $router->resource('group-invitations', GroupInvitationController::class);
     $router->resource('user-verifications', UserVerificationController::class);
     $router->resource('group-activity-trackings', GroupActivityTrackingController::class);
     $router->resource('group-timings', GroupTimingController::class);
     $router->resource('votings', VotingController::class);
     $router->resource('group-posts', GroupPostController::class);
     $router->resource('post-types', PostTypeController::class);
     $router->resource('group-limit-increase-requests', GroupLimitIncreaseRequestController::class);
     $router->resource('faqs', FaqController::class);
     $router->resource('privacy-policies', PrivacyPolicyController::class);
     $router->resource('event-images', EventImageController::class);
     $router->resource('app-settings', AppSettingController::class);
     $router->resource('notification-types', NotificationTypeController::class);
     $router->resource('notifications', NotificationController::class);
     $router->resource('packages', PackageController::class);
     $router->resource('payment-modes', PaymentModeController::class);
     $router->resource('products', ProductController::class);
     $router->resource('subscriptions', SubscriptionController::class);
     $router->resource('categories', CategoryController::class);
     $router->resource('user-categories', UserCategoryController::class);
     $router->resource('group-categories', GroupCategoryController::class);


});
