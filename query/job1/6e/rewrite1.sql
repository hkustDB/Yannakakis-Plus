create or replace view aggView6544506525584349013 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin7568824937262389238 as select movie_id as v23, v35 from movie_keyword as mk, aggView6544506525584349013 where mk.keyword_id=aggView6544506525584349013.v8;
create or replace view aggView1139028129352974658 as select v23, MIN(v35) as v35 from aggJoin7568824937262389238 group by v23;
create or replace view aggJoin3282307925804987503 as select id as v23, title as v24, v35 from title as t, aggView1139028129352974658 where t.id=aggView1139028129352974658.v23 and production_year>2000;
create or replace view aggView381479806850800723 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin3282307925804987503 group by v23;
create or replace view aggJoin5507251332913170818 as select person_id as v14, v35, v37 from cast_info as ci, aggView381479806850800723 where ci.movie_id=aggView381479806850800723.v23;
create or replace view aggView2239800135766192744 as select v14, MIN(v35) as v35, MIN(v37) as v37 from aggJoin5507251332913170818 group by v14;
create or replace view aggJoin2402823654586527723 as select name as v15, v35, v37 from name as n, aggView2239800135766192744 where n.id=aggView2239800135766192744.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin2402823654586527723;
