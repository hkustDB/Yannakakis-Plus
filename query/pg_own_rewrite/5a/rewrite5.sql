create or replace view aggView5095326650886690564 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin6401703158520423740 as select movie_id as v15, note as v9 from movie_companies as mc, aggView5095326650886690564 where mc.company_type_id=aggView5095326650886690564.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView4700299452869985321 as select id as v3 from info_type as it;
create or replace view aggJoin1690494412535439537 as select movie_id as v15, info as v13 from movie_info as mi, aggView4700299452869985321 where mi.info_type_id=aggView4700299452869985321.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView4589265143870305134 as select v15 from aggJoin6401703158520423740 group by v15;
create or replace view aggJoin3522400530241489180 as select v15, v13 from aggJoin1690494412535439537 join aggView4589265143870305134 using(v15);
create or replace view aggView4948114627324762269 as select v15 from aggJoin3522400530241489180 group by v15;
create or replace view aggJoin3921019260221165012 as select title as v16 from title as t, aggView4948114627324762269 where t.id=aggView4948114627324762269.v15 and production_year>2005;
select MIN(v16) as v27 from aggJoin3921019260221165012;
