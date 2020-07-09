module CoreTeacher

  class Modifications

    def self.update_pwd(argv)
      t_token = argv[:t_token]
      t_new_pwd = argv[:t_new_pwd]
      t_new_confirm_pwd = argv[:t_new_confirm_pwd]

      # search teacher existance
      if User.exists?(role_id: Role.find_by_name('teacher').id, token: t_token)
        current_teacher = User.find_by_token(t_token)

        # verifying password
        if t_new_pwd == t_new_confirm_pwd
          # authenticate user
          if current_teacher.statut == 'active' && deleted == nil
            # update password
            if current_teacher.update(password: t_new_pwd)

              # send SMS to teacher
              SmsJob.set(wait: 5.seconds).perform_later(phone: current_teacher.phone1, msg: "Mr/Mme #{current_teacher.name.upcase}, votre mot de passe à été modifié. Nouveau mot de passe : #{t_new_pwd}.\nMerci de vous rapprocher de l'administration si ce n'est pas vous l'auteur de cette modification.", structure: current_teacher.structure.name)

              # return infirmation success
              return true, "Mot de passe de Mr/Mme #{current_teacher.name.upcase} correctement modifié!"

            else

              puts "Impossible de modifier le mot de passe de Mr/Mme #{current_teacher.name}"
              return true, "Impossible de modifier le mot de passe de Mr/Mme #{current_teacher.name}"

            end

          else

            puts "Impossible de modifier le mot de passe, cet enseignant semble etre suspendu ou supprimé."
            return true, "Impossible de modifier le mot de passe, cet enseignant semble etre suspendu ou supprimé."

          end

        else

          return false, "Echec mise à jour", "Les mots de passe fournis ne sont pas identiques! Merci de les modifier."

        end

      else

        return false, "Impossible de trouver cet enseignant"

      end

    end

    # suspend teacher to course by mouving this teacher to new table
    def self.suspend(argv)

    end

    # remove suspension
    def self.unsuspend(argv)

    end

  end

end