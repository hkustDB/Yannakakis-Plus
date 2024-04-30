create or replace view aggView8052346054586300178 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin2466612966445004227 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView8052346054586300178 where mi.movie_id=aggView8052346054586300178.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView6626168912515769001 as select v12, MIN(v24) as v24 from aggJoin2466612966445004227 group by v12;
create or replace view aggJoin8335509255757753840 as select keyword_id as v1, v24 from movie_keyword as mk, aggView6626168912515769001 where mk.movie_id=aggView6626168912515769001.v12;
create or replace view aggView4610683486257305262 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin444956317074275619 as select v24 from aggJoin8335509255757753840 join aggView4610683486257305262 using(v1);
select MIN(v24) as v24 from aggJoin444956317074275619;
