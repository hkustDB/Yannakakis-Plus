create or replace view aggView7461673216282020733 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin672171500585105192 as select movie_id as v15, note as v9 from movie_companies as mc, aggView7461673216282020733 where mc.company_type_id=aggView7461673216282020733.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView3942618379648474258 as select v15 from aggJoin672171500585105192 group by v15;
create or replace view aggJoin7228402168710307517 as select id as v15, title as v16, production_year as v19 from title as t, aggView3942618379648474258 where t.id=aggView3942618379648474258.v15 and production_year>1990;
create or replace view aggView6094013545607034255 as select v15, MIN(v16) as v27 from aggJoin7228402168710307517 group by v15;
create or replace view aggJoin4335362060285471801 as select info_type_id as v3, info as v13, v27 from movie_info as mi, aggView6094013545607034255 where mi.movie_id=aggView6094013545607034255.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView8802318518858166328 as select id as v3 from info_type as it;
create or replace view aggJoin2557195694869951284 as select v27 from aggJoin4335362060285471801 join aggView8802318518858166328 using(v3);
select MIN(v27) as v27 from aggJoin2557195694869951284;
