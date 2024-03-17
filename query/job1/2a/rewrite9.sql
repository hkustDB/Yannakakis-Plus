create or replace view aggView2873597507647947239 as select id as v12, title as v31 from title as t;
create or replace view aggJoin2356426412634641894 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView2873597507647947239 where mc.movie_id=aggView2873597507647947239.v12;
create or replace view aggView4861832166240318509 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin6906984410921172242 as select v12, v31 from aggJoin2356426412634641894 join aggView4861832166240318509 using(v1);
create or replace view aggView5234380497092531815 as select v12, MIN(v31) as v31 from aggJoin6906984410921172242 group by v12;
create or replace view aggJoin3335244271715394218 as select keyword_id as v18, v31 from movie_keyword as mk, aggView5234380497092531815 where mk.movie_id=aggView5234380497092531815.v12;
create or replace view aggView4511450652939170058 as select v18, MIN(v31) as v31 from aggJoin3335244271715394218 group by v18;
create or replace view aggJoin3142483676806856598 as select keyword as v9, v31 from keyword as k, aggView4511450652939170058 where k.id=aggView4511450652939170058.v18 and keyword= 'character-name-in-title';
select MIN(v31) as v31 from aggJoin3142483676806856598;
