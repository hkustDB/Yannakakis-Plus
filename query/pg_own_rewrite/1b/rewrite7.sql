create or replace view aggView9142954777047386308 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4673289273704789664 as select movie_id as v15, note as v9 from movie_companies as mc, aggView9142954777047386308 where mc.company_type_id=aggView9142954777047386308.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView7242010075990458945 as select v15, MIN(v9) as v27 from aggJoin4673289273704789664 group by v15;
create or replace view aggJoin5139165493556830610 as select id as v15, title as v16, production_year as v19, v27 from title as t, aggView7242010075990458945 where t.id=aggView7242010075990458945.v15 and production_year<=2010 and production_year>=2005;
create or replace view aggView4632089472237777527 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin6464426643798234202 as select movie_id as v15 from movie_info_idx as mi_idx, aggView4632089472237777527 where mi_idx.info_type_id=aggView4632089472237777527.v3;
create or replace view aggView6268255703152887387 as select v15, MIN(v27) as v27, MIN(v16) as v28, MIN(v19) as v29 from aggJoin5139165493556830610 group by v15,v27;
create or replace view aggJoin74215404663721360 as select v27, v28, v29 from aggJoin6464426643798234202 join aggView6268255703152887387 using(v15);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin74215404663721360;
