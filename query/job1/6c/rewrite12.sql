create or replace view aggView3759229172056863412 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin5725319857285019448 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView3759229172056863412 where mk.movie_id=aggView3759229172056863412.v23;
create or replace view aggView5734643174832716996 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin2082165891287896936 as select v23, v37, v35 from aggJoin5725319857285019448 join aggView5734643174832716996 using(v8);
create or replace view aggView7461257509900571923 as select v23, MIN(v37) as v37, MIN(v35) as v35 from aggJoin2082165891287896936 group by v23;
create or replace view aggJoin1888740728528791344 as select person_id as v14, v37, v35 from cast_info as ci, aggView7461257509900571923 where ci.movie_id=aggView7461257509900571923.v23;
create or replace view aggView7234681795243744518 as select v14, MIN(v37) as v37, MIN(v35) as v35 from aggJoin1888740728528791344 group by v14;
create or replace view aggJoin2548907757715420795 as select name as v15, v37, v35 from name as n, aggView7234681795243744518 where n.id=aggView7234681795243744518.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin2548907757715420795;
