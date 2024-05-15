create or replace view aggView1621145259662538849 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin2498525269939434376 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView1621145259662538849 where mi.movie_id=aggView1621145259662538849.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView5554515334970653985 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5167972721532085212 as select movie_id as v12 from movie_keyword as mk, aggView5554515334970653985 where mk.keyword_id=aggView5554515334970653985.v1;
create or replace view aggView3731993846838898210 as select v12, MIN(v24) as v24 from aggJoin2498525269939434376 group by v12;
create or replace view aggJoin6250631186417301774 as select v24 from aggJoin5167972721532085212 join aggView3731993846838898210 using(v12);
select MIN(v24) as v24 from aggJoin6250631186417301774;
