create or replace view aggView1639471220147440282 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin108186743403627800 as select movie_id as v12 from movie_keyword as mk, aggView1639471220147440282 where mk.keyword_id=aggView1639471220147440282.v1;
create or replace view aggView2228656806395981048 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin6075275393216680333 as select v12 from aggJoin108186743403627800 join aggView2228656806395981048 using(v12);
create or replace view aggView2501585719948559981 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin8620848324259509815 as select v24 from aggJoin6075275393216680333 join aggView2501585719948559981 using(v12);
select MIN(v24) as v24 from aggJoin8620848324259509815;
