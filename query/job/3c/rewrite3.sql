create or replace view aggView1492128848346787097 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5589876754778593637 as select movie_id as v12 from movie_keyword as mk, aggView1492128848346787097 where mk.keyword_id=aggView1492128848346787097.v1;
create or replace view aggView1429118548439460442 as select v12 from aggJoin5589876754778593637 group by v12;
create or replace view aggJoin5057446558557868801 as select id as v12, title as v13, production_year as v16 from title as t, aggView1429118548439460442 where t.id=aggView1429118548439460442.v12 and production_year>1990;
create or replace view aggView7396086386726818583 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin849868871448986974 as select v13, v16 from aggJoin5057446558557868801 join aggView7396086386726818583 using(v12);
create or replace view aggView858336341418158717 as select v13 from aggJoin849868871448986974 group by v13;
select MIN(v13) as v24 from aggView858336341418158717;
