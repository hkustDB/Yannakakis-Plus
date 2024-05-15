create or replace view aggView1566913118844877984 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin1280291277791096516 as select movie_id as v15, note as v9 from movie_companies as mc, aggView1566913118844877984 where mc.company_type_id=aggView1566913118844877984.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView3654937166665836117 as select v15 from aggJoin1280291277791096516 group by v15;
create or replace view aggJoin1263253920374679754 as select movie_id as v15, info_type_id as v3, info as v13 from movie_info as mi, aggView3654937166665836117 where mi.movie_id=aggView3654937166665836117.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView2658539336411529311 as select id as v3 from info_type as it;
create or replace view aggJoin7417239491700359122 as select v15, v13 from aggJoin1263253920374679754 join aggView2658539336411529311 using(v3);
create or replace view aggView1769947036620610754 as select v15 from aggJoin7417239491700359122 group by v15;
create or replace view aggJoin3961988821163342800 as select title as v16 from title as t, aggView1769947036620610754 where t.id=aggView1769947036620610754.v15 and production_year>1990;
select MIN(v16) as v27 from aggJoin3961988821163342800;
