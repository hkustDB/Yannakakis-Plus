create or replace view aggView9126669983400406541 as select id as v12, title as v31 from title as t;
create or replace view aggJoin5799674469464515977 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView9126669983400406541 where mk.movie_id=aggView9126669983400406541.v12;
create or replace view aggView1564127711980313579 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin7718876868545197439 as select v12, v31 from aggJoin5799674469464515977 join aggView1564127711980313579 using(v18);
create or replace view aggView7706218914706649646 as select v12, MIN(v31) as v31 from aggJoin7718876868545197439 group by v12;
create or replace view aggJoin5894234560630679200 as select company_id as v1, v31 from movie_companies as mc, aggView7706218914706649646 where mc.movie_id=aggView7706218914706649646.v12;
create or replace view aggView3082636073616870145 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin6444782845628298812 as select v31 from aggJoin5894234560630679200 join aggView3082636073616870145 using(v1);
select MIN(v31) as v31 from aggJoin6444782845628298812;
