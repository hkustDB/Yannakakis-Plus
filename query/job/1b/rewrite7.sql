create or replace view aggView5867658761740955404 as select id as v15, title as v28, production_year as v29 from title as t where production_year<=2010 and production_year>=2005;
create or replace view aggJoin7502112668841489454 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView5867658761740955404 where mc.movie_id=aggView5867658761740955404.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView605899734236273578 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin6489893046200798342 as select v15, v9, v28, v29 from aggJoin7502112668841489454 join aggView605899734236273578 using(v1);
create or replace view aggView2882051653250341065 as select v15, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin6489893046200798342 group by v15;
create or replace view aggJoin2731985679363590336 as select info_type_id as v3, v28, v29, v27 from movie_info_idx as mi_idx, aggView2882051653250341065 where mi_idx.movie_id=aggView2882051653250341065.v15;
create or replace view aggView3598312163106392579 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin9023226665620223927 as select v28, v29, v27 from aggJoin2731985679363590336 join aggView3598312163106392579 using(v3);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin9023226665620223927;
