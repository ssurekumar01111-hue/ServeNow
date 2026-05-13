@admin_panel_fresh\vendor\laravel\framework\src\Illuminate\Foundation\Console\stubs\echo-bootstrap-js.stub off
echo Deploying ServeNow Firestore indexes and rules...
firebase deploy --only firestore:indexes,firestore:rules,storage
echo Done! Indexes and rules deployed successfully.
pause
