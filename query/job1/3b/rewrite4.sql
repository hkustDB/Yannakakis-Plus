create or replace view aggView5248625958622993958 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6619578995335779499 as select movie_id as v12 from movie_keyword as mk, aggView5248625958622993958 where mk.keyword_id=aggView5248625958622993958.v1;
create or replace view aggView1546715653651591046 as select v12 from aggJoin6619578995335779499 group by v12;
create or replace view aggJoin5752648342759404815 as select id as v12, title as v13 from title as t, aggView1546715653651591046 where t.id=aggView1546715653651591046.v12 and production_year>2010;
create or replace view aggView4008381639735970024 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin5646914428583061327 as select v13 from aggJoin5752648342759404815 join aggView4008381639735970024 using(v12);
create or replace view res as select MIN(v13) as v24 from aggJoin5646914428583061327;
select sum(v24) from res;