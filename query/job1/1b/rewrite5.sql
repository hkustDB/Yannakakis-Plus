create or replace view aggView8898109633922804184 as select id as v15, title as v28, production_year as v29 from title as t where production_year<=2010 and production_year>=2005;
create or replace view aggJoin1461205342150271407 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView8898109633922804184 where mc.movie_id=aggView8898109633922804184.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView4817100312101855638 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3045657196782711614 as select v15, v9, v28, v29 from aggJoin1461205342150271407 join aggView4817100312101855638 using(v1);
create or replace view aggView8009716565840356991 as select v15, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin3045657196782711614 group by v15;
create or replace view aggJoin3042642583339917933 as select info_type_id as v3, v28, v29, v27 from movie_info_idx as mi_idx, aggView8009716565840356991 where mi_idx.movie_id=aggView8009716565840356991.v15;
create or replace view aggView7500849486805438262 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin9016949846134315099 as select v28, v29, v27 from aggJoin3042642583339917933 join aggView7500849486805438262 using(v3);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin9016949846134315099;
