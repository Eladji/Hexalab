<?php
class Content 
{
    private string $Name;
    private string $Description;
    private string $Creation_Date;
    private string $Path;
    private int $Author_id;
    private int $Type_id;

    public function __construct(array $data)
    {
        $this->hydrate($data);
    }

    public function hydrate(array $data): void
    {
        foreach ($data as $key => $value) {
            // On récupère le nom du setter correspondant à l'attribut
            // Convertit les clés comme 'author_id' ou 'Author_id' en 'AuthorId'
            $transformedKey = str_replace('_', '', ucwords(strtolower($key), '_'));
            $method = 'set' . $transformedKey;

            // Si le setter existe dans la classe, on l'appelle
            if (method_exists($this, $method)) {
                $this->$method($value);
            }
        }
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

    /**
     * Get the value of Creation_Date
     */
    public function getCreationDate(): string
    {
        return $this->Creation_Date;
    }

    /**
     * Set the value of Creation_Date
     */
    public function setCreationDate(string $Creation_Date): self
    {
        $this->Creation_Date = $Creation_Date;

        return $this;
    }

    /**
     * Get the value of Path
     */
    public function getPath(): string
    {
        return $this->Path;
    }

    /**
     * Set the value of Path
     */
    public function setPath(string $Path): self
    {
        $this->Path = $Path;

        return $this;
    }

    /**
     * Get the value of Author_id
     */
    public function getAuthorId(): int
    {
        return $this->Author_id;
    }

    /**
     * Set the value of Author_id
     */
    public function setAuthorId(int $Author_id): self
    {
        $this->Author_id = $Author_id;

        return $this;
    }

    /**
     * Get the value of Type_id
     */
    public function getTypeId(): int
    {
        return $this->Type_id;
    }

    /**
     * Set the value of Type_id
     */
    public function setTypeId(int $Type_id): self
    {
        $this->Type_id = $Type_id;

        return $this;
    }
    }
    