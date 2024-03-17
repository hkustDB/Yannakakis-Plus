create or replace view aggView6820025731713258281 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin3962943783425499750 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView6820025731713258281 where mi.movie_id=aggView6820025731713258281.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView2183077178015843615 as select v12, MIN(v24) as v24 from aggJoin3962943783425499750 group by v12;
create or replace view aggJoin3701164201332879515 as select keyword_id as v1, v24 from movie_keyword as mk, aggView2183077178015843615 where mk.movie_id=aggView2183077178015843615.v12;
create or replace view aggView9080177828429552193 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5425834955568179337 as select v24 from aggJoin3701164201332879515 join aggView9080177828429552193 using(v1);
select MIN(v24) as v24 from aggJoin5425834955568179337;
