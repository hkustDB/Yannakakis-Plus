create or replace view aggView2427336899952299452 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin5659627319535736772 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView2427336899952299452 where mk.movie_id=aggView2427336899952299452.v12;
create or replace view aggView175736586259766173 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin4735159438200288345 as select v1, v24 as v24 from aggJoin5659627319535736772 join aggView175736586259766173 using(v12);
create or replace view aggView3614496755106194418 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5706740938600364053 as select v24 from aggJoin4735159438200288345 join aggView3614496755106194418 using(v1);
select MIN(v24) as v24 from aggJoin5706740938600364053;
