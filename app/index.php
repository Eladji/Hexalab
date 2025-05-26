<?php
require "header.php";
require "class/UserController.php";
$Usermanager = new UserController();
require "class/Contentcontroller.php";
$Contentmanager = new ContentController();
$contents = $Contentmanager->getAllContents();
?>
<!DOCTYPE html>
<html lang="en">
  <script src="script.js"></script>

<body>

  <div class="card-container" >
    <?php foreach ($contents as $content): ?>
  <div class="card" onclick="classList.toggle('expanded')">
    <img src="<?php echo $content->getPath(); ?>" alt="">
    <div class="card-body">
      <h3 class="card-title"><?php echo $content->getName(); ?></h3>
      <p class="card-desc"><?php echo $content->getDescription(); ?></p>
      <p class="card-author"><?php echo $Usermanager->getUserById($content->getAuthorId())->getFirstName(); ?></p>
    </div>
  </div>
<?php endforeach; ?>

</div>
</body>
</html>