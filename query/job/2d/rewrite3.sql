create or replace view aggView6194573303386265846 as select id as v12, title as v31 from title as t;
create or replace view aggJoin3233391630426476114 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView6194573303386265846 where mc.movie_id=aggView6194573303386265846.v12;
create or replace view aggView5530524770545471552 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin756180107993030224 as select v12, v31 from aggJoin3233391630426476114 join aggView5530524770545471552 using(v1);
create or replace view aggView5949830182434847713 as select v12, MIN(v31) as v31 from aggJoin756180107993030224 group by v12;
create or replace view aggJoin5165092410089442704 as select keyword_id as v18, v31 from movie_keyword as mk, aggView5949830182434847713 where mk.movie_id=aggView5949830182434847713.v12;
create or replace view aggView911912048521341465 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin2981800152036581716 as select v31 from aggJoin5165092410089442704 join aggView911912048521341465 using(v18);
select MIN(v31) as v31 from aggJoin2981800152036581716;
