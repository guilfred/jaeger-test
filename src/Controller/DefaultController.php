<?php

namespace App\Controller;

use App\Entity\Info;
use App\Form\InfoType;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class DefaultController extends AbstractController
{
    #[Route('/', name: 'der', methods: ['POST'])]
    public function create(Request $request): Response
    {
        $data = json_decode($request->getContent(), true);
        $info = new Info();
        $form = $this->createForm(InfoType::class, $info);
        $form->submit($data);

        return $this->json($data, Response::HTTP_CREATED, []);
    }
}
