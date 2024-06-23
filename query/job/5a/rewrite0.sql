create or replace view aggView877865654012392529 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin905973499370563709 as select movie_id as v15, note as v9 from movie_companies as mc, aggView877865654012392529 where mc.company_type_id=aggView877865654012392529.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView4755453558411552794 as select v15 from aggJoin905973499370563709 group by v15;
create or replace view aggJoin8352125735168658411 as select id as v15, title as v16, production_year as v19 from title as t, aggView4755453558411552794 where t.id=aggView4755453558411552794.v15 and production_year>2005;
create or replace view aggView441501405667583956 as select v15, MIN(v16) as v27 from aggJoin8352125735168658411 group by v15;
create or replace view aggJoin8296807024890032679 as select info_type_id as v3, info as v13, v27 from movie_info as mi, aggView441501405667583956 where mi.movie_id=aggView441501405667583956.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView7416564158695526426 as select id as v3 from info_type as it;
create or replace view aggJoin2425205151760604833 as select v13, v27 from aggJoin8296807024890032679 join aggView7416564158695526426 using(v3);
select MIN(v27) as v27 from aggJoin2425205151760604833;
