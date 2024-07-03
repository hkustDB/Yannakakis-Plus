create or replace view aggView5379525275061384406 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3492683608171183039 as select movie_id as v12 from movie_keyword as mk, aggView5379525275061384406 where mk.keyword_id=aggView5379525275061384406.v1;
create or replace view aggView5444483968096186138 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin3697148065381327765 as select v12 from aggJoin3492683608171183039 join aggView5444483968096186138 using(v12);
create or replace view aggView8425439611991939106 as select v12 from aggJoin3697148065381327765 group by v12;
create or replace view aggJoin7949214510170178514 as select title as v13, production_year as v16 from title as t, aggView8425439611991939106 where t.id=aggView8425439611991939106.v12 and production_year>2005;
create or replace view aggView5246786109408904278 as select v13 from aggJoin7949214510170178514;
select MIN(v13) as v24 from aggView5246786109408904278;
