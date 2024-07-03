create or replace view aggView8835250394799703581 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin8322012461395187278 as select movie_id as v12 from movie_companies as mc, aggView8835250394799703581 where mc.company_id=aggView8835250394799703581.v1;
create or replace view aggView2933702888321725782 as select v12 from aggJoin8322012461395187278 group by v12;
create or replace view aggJoin8098875064699875821 as select id as v12, title as v20 from title as t, aggView2933702888321725782 where t.id=aggView2933702888321725782.v12;
create or replace view aggView1418143744666473964 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin120053324048788974 as select movie_id as v12 from movie_keyword as mk, aggView1418143744666473964 where mk.keyword_id=aggView1418143744666473964.v18;
create or replace view aggView7253024491828884112 as select v12, MIN(v20) as v31 from aggJoin8098875064699875821 group by v12;
create or replace view aggJoin3957649983311121237 as select v31 from aggJoin120053324048788974 join aggView7253024491828884112 using(v12);
select MIN(v31) as v31 from aggJoin3957649983311121237;
