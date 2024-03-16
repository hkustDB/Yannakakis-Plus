create or replace view aggView8558187082130618750 as select id as v15, title as v27 from title as t where production_year>1990;
create or replace view aggJoin2395305822081605382 as select movie_id as v15, company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView8558187082130618750 where mc.movie_id=aggView8558187082130618750.v15 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView5581967768744073311 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin6617094092583880178 as select v15, v9, v27 from aggJoin2395305822081605382 join aggView5581967768744073311 using(v1);
create or replace view aggView6832383287750809119 as select v15, MIN(v27) as v27 from aggJoin6617094092583880178 group by v15;
create or replace view aggJoin2625617035049795458 as select info_type_id as v3, info as v13, v27 from movie_info as mi, aggView6832383287750809119 where mi.movie_id=aggView6832383287750809119.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView629968520023253243 as select id as v3 from info_type as it;
create or replace view aggJoin4217013034831414541 as select v13, v27 from aggJoin2625617035049795458 join aggView629968520023253243 using(v3);
select MIN(v27) as v27 from aggJoin4217013034831414541;
