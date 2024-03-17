create or replace view aggView5945177545424542286 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin1893971822181194079 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView5945177545424542286 where mk.movie_id=aggView5945177545424542286.v12;
create or replace view aggView5769815491345746255 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin5301441370063406348 as select v1, v24 as v24 from aggJoin1893971822181194079 join aggView5769815491345746255 using(v12);
create or replace view aggView5604587419365913350 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4288528445874295488 as select v24 from aggJoin5301441370063406348 join aggView5604587419365913350 using(v1);
create or replace view res as select MIN(v24) as v24 from aggJoin4288528445874295488;
select sum(v24) from res;