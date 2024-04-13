create or replace view aggView1974437782010518865 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin2267994317832259918 as select movie_id as v12 from movie_companies as mc, aggView1974437782010518865 where mc.company_id=aggView1974437782010518865.v1;
create or replace view aggView7077676730842619551 as select v12 from aggJoin2267994317832259918 group by v12;
create or replace view aggJoin4393203593208365169 as select id as v12, title as v20 from title as t, aggView7077676730842619551 where t.id=aggView7077676730842619551.v12;
create or replace view aggView5041764784401961230 as select v12, MIN(v20) as v31 from aggJoin4393203593208365169 group by v12;
create or replace view aggJoin5475143237654831776 as select keyword_id as v18, v31 from movie_keyword as mk, aggView5041764784401961230 where mk.movie_id=aggView5041764784401961230.v12;
create or replace view aggView7041145035814145693 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin98737212389631995 as select v31 from aggJoin5475143237654831776 join aggView7041145035814145693 using(v18);
select MIN(v31) as v31 from aggJoin98737212389631995;
