package de.treverix.model

import java.io.Serializable
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Table
import javax.persistence.UniqueConstraint
import javax.validation.constraints.Digits
import javax.validation.constraints.NotNull
import javax.validation.constraints.Pattern
import javax.validation.constraints.Size
import javax.xml.bind.annotation.XmlRootElement
import org.hibernate.validator.constraints.Email
import org.hibernate.validator.constraints.NotEmpty
import org.eclipse.xtend.lib.annotations.Accessors

@Entity
@XmlRootElement
@Table(name="Registrant", uniqueConstraints=@UniqueConstraint(columnNames="email"))
@Accessors
class Member implements Serializable {
    /**
     * Default value included to remove warning. Remove or modify at will.
     */
    static final long serialVersionUID = 1L

    @Id @GeneratedValue
    Long id

    @NotNull @Size(min=1, max=25) @Pattern(regexp="[^0-9]*", message="Must not contain numbers")
    String name

    @NotNull @NotEmpty @Email
    String email

    @NotNull @Size(min=10, max=12) @Digits(fraction=0, integer=12)
    @Column(name="phone_number")
    String phoneNumber
}
