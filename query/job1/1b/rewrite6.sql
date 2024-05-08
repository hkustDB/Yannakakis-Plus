create or replace view aggView4917744586280663325 as select id as v15, title as v28, production_year as v29 from title as t where production_year<=2010 and production_year>=2005;
create or replace view aggJoin7773381193041857538 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView4917744586280663325 where mi_idx.movie_id=aggView4917744586280663325.v15;
create or replace view aggView703973610933974350 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin8796942712374425685 as select v15, v28, v29 from aggJoin7773381193041857538 join aggView703973610933974350 using(v3);
create or replace view aggView4828595587625672228 as select v15, MIN(v28) as v28, MIN(v29) as v29 from aggJoin8796942712374425685 group by v15;
create or replace view aggJoin2925889503791743665 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView4828595587625672228 where mc.movie_id=aggView4828595587625672228.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView3002373540068857262 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4240992813911089492 as select v9, v28, v29 from aggJoin2925889503791743665 join aggView3002373540068857262 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin4240992813911089492;
