create or replace view aggView6754390926148207243 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin6295920348496440336 as select movie_id as v15, note as v9 from movie_companies as mc, aggView6754390926148207243 where mc.company_type_id=aggView6754390926148207243.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView6159565852974129731 as select v15 from aggJoin6295920348496440336 group by v15;
create or replace view aggJoin6550093100076674777 as select movie_id as v15, info_type_id as v3, info as v13 from movie_info as mi, aggView6159565852974129731 where mi.movie_id=aggView6159565852974129731.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView3286758699405730240 as select id as v3 from info_type as it;
create or replace view aggJoin690588324406373874 as select v15, v13 from aggJoin6550093100076674777 join aggView3286758699405730240 using(v3);
create or replace view aggView5617499534494555575 as select v15 from aggJoin690588324406373874 group by v15;
create or replace view aggJoin3123799500094937917 as select title as v16 from title as t, aggView5617499534494555575 where t.id=aggView5617499534494555575.v15 and production_year>1990;
select MIN(v16) as v27 from aggJoin3123799500094937917;
