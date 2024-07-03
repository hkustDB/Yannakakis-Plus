create or replace view aggView7992618177446792428 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin5587774582055242873 as select movie_id as v15, note as v9 from movie_companies as mc, aggView7992618177446792428 where mc.company_type_id=aggView7992618177446792428.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView7771783963573655323 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin1595651007256773874 as select movie_id as v15 from movie_info_idx as mi_idx, aggView7771783963573655323 where mi_idx.info_type_id=aggView7771783963573655323.v3;
create or replace view aggView7559231588060853540 as select v15, MIN(v9) as v27 from aggJoin5587774582055242873 group by v15;
create or replace view aggJoin4881392676760244994 as select v15, v27 from aggJoin1595651007256773874 join aggView7559231588060853540 using(v15);
create or replace view aggView3649299826173698709 as select v15, MIN(v27) as v27 from aggJoin4881392676760244994 group by v15,v27;
create or replace view aggJoin5619965567276523974 as select title as v16, production_year as v19, v27 from title as t, aggView3649299826173698709 where t.id=aggView3649299826173698709.v15 and production_year>2000;
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin5619965567276523974;
