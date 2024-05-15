create or replace view aggView5474683916215459059 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2697799634739473288 as select movie_id as v15, note as v9 from movie_companies as mc, aggView5474683916215459059 where mc.company_type_id=aggView5474683916215459059.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView5009906703180812631 as select id as v3 from info_type as it;
create or replace view aggJoin6720690310919461523 as select movie_id as v15, info as v13 from movie_info as mi, aggView5009906703180812631 where mi.info_type_id=aggView5009906703180812631.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView1002104680004319293 as select v15 from aggJoin2697799634739473288 group by v15;
create or replace view aggJoin7466796094168658341 as select id as v15, title as v16, production_year as v19 from title as t, aggView1002104680004319293 where t.id=aggView1002104680004319293.v15 and production_year>1990;
create or replace view aggView7444624224617573152 as select v15 from aggJoin6720690310919461523 group by v15;
create or replace view aggJoin8505200764590049022 as select v16 from aggJoin7466796094168658341 join aggView7444624224617573152 using(v15);
select MIN(v16) as v27 from aggJoin8505200764590049022;
