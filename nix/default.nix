{ stdenv
, cmake
, pkg-config
}:

stdenv.mkDerivation {
  pname = "myctrl";
  version = "0.1.0";

  # Указываем корень всего репозитория (поднимаемся из папки nix на уровень вверх)
  src = ./..; 

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  # Убираем кастомные cmakeFlags и installPhase, так как стандартный 
  # обработчик cmake в NixOS сделает всё сам идеально автоматически.
}
