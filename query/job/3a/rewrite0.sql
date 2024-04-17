create or replace view aggView2093471037475383715 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1682763527592595285 as select movie_id as v12 from movie_keyword as mk, aggView2093471037475383715 where mk.keyword_id=aggView2093471037475383715.v1;
create or replace view aggView448305648680428352 as select v12 from aggJoin1682763527592595285 group by v12;
create or replace view aggJoin8925094469940821448 as select movie_id as v12, info as v7 from movie_info as mi, aggView448305648680428352 where mi.movie_id=aggView448305648680428352.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView6009278847326223286 as select v12 from aggJoin8925094469940821448 group by v12;
create or replace view aggJoin6313468132014458240 as select title as v13, production_year as v16 from title as t, aggView6009278847326223286 where t.id=aggView6009278847326223286.v12 and production_year>2005;
create or replace view aggView6390933865252101871 as select v13 from aggJoin6313468132014458240 group by v13;
select MIN(v13) as v24 from aggView6390933865252101871;
