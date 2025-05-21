<?php
class Peripheric
{
    private int $id;
    private string $Name;
    private string $Type;
    private string $Description;
    
    public function __construct(array $data)
    {
        $this->hydrate($data);
    }

    public function hydrate(array $data): void
    {
        foreach ($data as $key => $value) {
            // On récupère le nom du setter correspondant à l'attribut
            $method = 'set' . ucfirst($key);

            // Si le setter existe dans la classe, on l'appelle
            if (method_exists($this, $method)) {
                $this->$method($value);
            }
        }
    }
    


    /**
     * Get the value of id
     */
    public function getId(): int
    {
        return $this->id;
    }

    /**
     * Set the value of id
     */
    public function setId(int $id): self
    {
        $this->id = $id;

        return $this;
    }

    /**
     * Get the value of Name
     */
    public function getName(): string
    {
        return $this->Name;
    }

    /**
     * Set the value of Name
     */
    public function setName(string $Name): self
    {
        $this->Name = $Name;

        return $this;
    }

    /**
     * Get the value of Type
     */
    public function getType(): string
    {
        return $this->Type;
    }

    /**
     * Set the value of Type
     */
    public function setType(string $Type): self
    {
        $this->Type = $Type;

        return $this;
    }

    /**
     * Get the value of Description
     */
    public function getDescription(): string
    {
        return $this->Description;
    }

    /**
     * Set the value of Description
     */
    public function setDescription(string $Description): self
    {
        $this->Description = $Description;

        return $this;
    }
}