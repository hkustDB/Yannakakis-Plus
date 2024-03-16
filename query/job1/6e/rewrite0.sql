create or replace view aggView6912976623143777808 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin7858133037426393238 as select movie_id as v23, v35 from movie_keyword as mk, aggView6912976623143777808 where mk.keyword_id=aggView6912976623143777808.v8;
create or replace view aggView9140454853278540378 as select v23, MIN(v35) as v35 from aggJoin7858133037426393238 group by v23;
create or replace view aggJoin4056445036584478201 as select id as v23, title as v24, v35 from title as t, aggView9140454853278540378 where t.id=aggView9140454853278540378.v23 and production_year>2000;
create or replace view aggView6363955395291974762 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin4056445036584478201 group by v23;
create or replace view aggJoin6855509996102227965 as select person_id as v14, v35, v37 from cast_info as ci, aggView6363955395291974762 where ci.movie_id=aggView6363955395291974762.v23;
create or replace view aggView5505878072584591778 as select v14, MIN(v35) as v35, MIN(v37) as v37 from aggJoin6855509996102227965 group by v14;
create or replace view aggJoin1154515390191548060 as select name as v15, v35, v37 from name as n, aggView5505878072584591778 where n.id=aggView5505878072584591778.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin1154515390191548060;
