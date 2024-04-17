create or replace view aggView150845945648860692 as select id as v23, title as v37 from title as t where production_year>2010;
create or replace view aggJoin2598829295395417532 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView150845945648860692 where mk.movie_id=aggView150845945648860692.v23;
create or replace view aggView7946051233901644593 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin1722384318317574955 as select v23, v37, v35 from aggJoin2598829295395417532 join aggView7946051233901644593 using(v8);
create or replace view aggView7794257729425407114 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin7512463486485930047 as select movie_id as v23, v36 from cast_info as ci, aggView7794257729425407114 where ci.person_id=aggView7794257729425407114.v14;
create or replace view aggView8639703904992063262 as select v23, MIN(v37) as v37, MIN(v35) as v35 from aggJoin1722384318317574955 group by v23,v37,v35;
create or replace view aggJoin5430380602396073318 as select v36 as v36, v37, v35 from aggJoin7512463486485930047 join aggView8639703904992063262 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin5430380602396073318;
