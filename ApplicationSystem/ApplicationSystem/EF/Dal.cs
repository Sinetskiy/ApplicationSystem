using ApplicationSystem.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace ApplicationSystem.EF
{
    public class Dal : DbContext
    {
        public Dal() : base("applicationDb") { }

        public DbSet<Application> Applications { get; set; }
        public DbSet<SystemUser> SystemUsers { get; set; }
        public DbSet<Role> Roles { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Application>().ToTable("Applications");
            modelBuilder.Entity<Application>().HasKey(v => v.ApplicationId);

            modelBuilder.Entity<SystemUser>().ToTable("SystemUsers");
            modelBuilder.Entity<SystemUser>().HasKey(v => v.SystemUserId);

            modelBuilder.Entity<Role>().ToTable("Roles");
            modelBuilder.Entity<Role>().HasKey(v => v.RoleId);

            modelBuilder.Entity<SystemUser>()
                           .HasMany<Role>(s => s.Roles)
                           .WithMany(c => c.SystemUsers)
                           .Map(cs =>
                           {
                               cs.MapLeftKey("SystemUserId");
                               cs.MapRightKey("RoleId");
                               cs.ToTable("SystemUserRole");
                           });

        }
    }
}